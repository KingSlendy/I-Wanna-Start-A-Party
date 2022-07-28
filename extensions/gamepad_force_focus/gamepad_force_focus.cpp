/// @author YellowAfterlife

#include "stdafx.h"
#include <Windows.h>
#include <Dbghelp.h>
#include <shellapi.h>

#if defined(WIN32)
#define dllx extern "C" __declspec(dllexport)
#elif defined(GNUC)
#define dllx extern "C" __attribute__ ((visibility("default"))) 
#else
#define dllx extern "C"
#endif

#define trace(...) { printf("[window_force_focus:%d] ", __LINE__); printf(__VA_ARGS__); printf("\n"); fflush(stdout); }

//
#pragma region https://github.com/andreasjhkarlsson/winapi-hooking-demo
BOOL ModifyImportTable(IMAGE_IMPORT_DESCRIPTOR* iid, void* target, void* replacement)
{
	IMAGE_THUNK_DATA* itd = (IMAGE_THUNK_DATA*)(((char*)GetModuleHandle(NULL)) + iid->FirstThunk);

	while (itd->u1.Function)
	{
		if (((void*)itd->u1.Function) == target)
		{
			// Temporary change access to memory area to READWRITE
			MEMORY_BASIC_INFORMATION mbi;
			VirtualQuery(itd, &mbi, sizeof(MEMORY_BASIC_INFORMATION));
			VirtualProtect(mbi.BaseAddress, mbi.RegionSize, PAGE_READWRITE, &mbi.Protect);

			// Replace entry!!
			*((void**)itd) = replacement;

			// Restore memory permissions
			VirtualProtect(mbi.BaseAddress, mbi.RegionSize, mbi.Protect, &mbi.Protect);

			return TRUE;
		}

		itd += 1;
	}
	return FALSE;
}

BOOL InstallHook(LPCSTR module, LPCSTR function, void* hook, void** original)
{
	HMODULE process = GetModuleHandle(NULL);

	// Save original address to function
	*original = (void*)GetProcAddress(GetModuleHandleA(module), function);

	ULONG entrySize;

	IMAGE_IMPORT_DESCRIPTOR* iid = (IMAGE_IMPORT_DESCRIPTOR*)ImageDirectoryEntryToData(process, 1, IMAGE_DIRECTORY_ENTRY_IMPORT, &entrySize);

	// Search for module
	while (iid->Name)
	{
		const char* name = ((char*)process) + iid->Name;

		if (stricmp(name, module) == 0)
		{
			return ModifyImportTable(iid, *original, hook);
		}
		iid += 1;
	}

	return FALSE;
}
#pragma endregion

// for sanity
template<typename T>
BOOL InstallHookPlus(LPCSTR module, LPCSTR function, T proto, T hook, T* out_orig) {
	return InstallHook(module, function, hook, (void**)out_orig);
}

HWND GetActiveWindow_result = 0;
bool GetActiveWindow_isReady = false;
bool GetActiveWindow_useResult = false;
HWND(__stdcall*GetActiveWindow_base)();
HWND __stdcall GetActiveWindow_hook() {
	if (GetActiveWindow_useResult) {
		return GetActiveWindow_result;
	} else return GetActiveWindow_base();
}

dllx double gamepad_force_focus_raw(void* hwnd, double enable) {
	GetActiveWindow_result = (HWND)hwnd;
	GetActiveWindow_useResult = enable > 0.5;
	if (!GetActiveWindow_isReady) {
		GetActiveWindow_isReady = InstallHookPlus("User32.dll", "GetActiveWindow", GetActiveWindow,
			GetActiveWindow_hook, &GetActiveWindow_base);
	}
	return GetActiveWindow_isReady;
}
