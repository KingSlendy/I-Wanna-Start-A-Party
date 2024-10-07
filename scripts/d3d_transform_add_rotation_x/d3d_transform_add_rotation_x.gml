/// @description d3d - Sets the transformation to a rotation around the x-axis with the indicated amount.
/// @param angle the angle to rotate
function d3d_transform_add_rotation_x(argument0) {

	// get the sin and cos of the angle passed in
	var c = dcos(argument0);
	var s = dsin(argument0);

	// build the rotation matrix
	var mT = matrix_build_identity();
	mT[5] = c;
	mT[6] = -s;

	mT[9] = s;
	mT[10] = c;

	var m = matrix_get( matrix_world );
	var mR = matrix_multiply( m, mT );
	matrix_set( matrix_world, mR );


}
