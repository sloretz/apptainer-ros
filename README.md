singularity build --fakeroot rosfocal.sif definition_files/ros.focal


singularity instance start --containall --writable-tmpfs rosfocal.sif rosfocalinstance
