`ifndef CACHES_TYPES_PKG_VH
`define CACHES_TYPES_PKG_VH

package caches_types_pkg;

    parameter ICACHEROWS = 16;

    typedef enum logic {
        IDLE,
        UPDATE
    } icache_state_t;

    parameter DCACHEROWS = 8;
    parameter DCACHECOLUMNS = 2;

    typedef enum logic [3:0] {
        INITIAL,
        CLEANWRITE,
        CLEANFLAG,
        MEMREAD,
        READFLAG,
        RAMWRITE0,
        RAMWRITE1,
        HALTCACHE,
        SNOOPED,
        FLUSHED
    } dcache_state_t;

endpackage : caches_types_pkg

`endif
