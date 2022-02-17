hal -sv -TOP dcache -SMARTORDER ./source/dcache.sv ./include/caches_if.vh ./include/datapath_cache_if.vh ./cpu_types_pkg.vh ./include/caches_types_pkg.vh
ncbrowse -cdslib ./INCA_libs/irun.nc/cds.lib -hdlvar ./INCA_libs/irun.nc/hdl.var -sortby severity -sortby category -sortby tag hal.log
