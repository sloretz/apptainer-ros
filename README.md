singularity build --fakeroot ros.focal.sandbox definition_files/ros.focal


singularity shell --fakeroot --writable ./ros.focal.sandbox

singularity shell --contain --writable ./ros.focal.sandbox
