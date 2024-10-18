/// @description Clears the model with the given index, removing all its primitives.
/// @param ind The index of the model to be cleared.
/// @returns 
function d3d_model_clear(argument0) {

	var __m = argument0;

	// Scrub any buffers we have created
	if (__m[e__YYM.PointB] != undefined && buffer_exists(__m[e__YYM.PointB]))
	{
		buffer_delete(__m[e__YYM.PointB]);
		__m[e__YYM.PointB] = undefined;
	}

	if (__m[e__YYM.LineB] != undefined && buffer_exists(__m[e__YYM.LineB]))
	{
		buffer_delete(__m[e__YYM.LineB]);
		__m[e__YYM.LineB] = undefined;
	}

	if (__m[e__YYM.TriB] != undefined && buffer_exists(__m[e__YYM.TriB]))
	{
		buffer_delete(__m[e__YYM.TriB]);
		__m[e__YYM.TriB] = undefined;
	}

	if (__m[e__YYM.PointUVB] != undefined && buffer_exists(__m[e__YYM.PointUVB]))
	{
		buffer_delete(__m[e__YYM.PointUVB]);
		__m[e__YYM.PointUVB] = undefined;
	}

	if (__m[e__YYM.LineUVB] != undefined && buffer_exists(__m[e__YYM.LineUVB]))
	{
		buffer_delete(__m[e__YYM.LineUVB]);
		__m[e__YYM.LineUVB] = undefined;
	}

	if (__m[e__YYM.TriUVB] != undefined && buffer_exists(__m[e__YYM.TriUVB]))
	{
		buffer_delete(__m[e__YYM.TriUVB]);
		__m[e__YYM.TriUVB] = undefined;
	}
	
	try {
		// Scrub any vertex buffers we have created
		if (__m[e__YYM.PointVB] != undefined)
		{
			vertex_delete_buffer(__m[e__YYM.PointVB]);
			__m[e__YYM.PointVB] = undefined;
		}

		if (__m[e__YYM.LineVB] != undefined)
		{
			vertex_delete_buffer(__m[e__YYM.LineVB]);
			__m[e__YYM.LineVB] = undefined;
		}

		if (__m[e__YYM.TriVB] != undefined)
		{
			vertex_delete_buffer(__m[e__YYM.TriVB]);
			__m[e__YYM.TriVB] = undefined;
		}
	} catch (_) {}

	// Set num verts to zero
	__m[e__YYM.NumVerts] = 0;
	__m[e__YYM.NumPointCols] = 0;
	__m[e__YYM.NumLineCols] = 0;
	__m[e__YYM.NumTriCols] = 0;


}
