module Pot8o

export po_initialize
export po_read_msh_file
export po_write_forest_vtk
export po_finalize

using MPI
using T8code
using T8code.Libt8: sc_init
using T8code.Libt8: sc_free
using T8code.Libt8: sc_finalize
using T8code.Libt8: sc_array_new_data
using T8code.Libt8: sc_array_destroy
using T8code.Libt8: SC_LP_ESSENTIAL
using T8code.Libt8: SC_LP_PRODUCTION

_forest = nothing
_comm = nothing

function po_initialize()
    # Initialize MPI. This has to happen before we initialize sc or t8code.
    mpiret = MPI.Init()

    # We will use MPI_COMM_WORLD as a communicator.
    global _comm = MPI.COMM_WORLD

    # Initialize the sc library, has to happen before we initialize t8code.
    sc_init(_comm, 1, 1, C_NULL, SC_LP_ESSENTIAL)
    # Initialize t8code with log level SC_LP_PRODUCTION. See sc.h for more info on the log levels.
    t8_init(SC_LP_PRODUCTION)
end

function po_read_msh_file(fileprefix, dim)
    cmesh = t8_cmesh_from_msh_file(fileprefix, 0, _comm, dim, 0, 0)
    global _forest = t8_forest_new_uniform(cmesh, t8_scheme_new_default_cxx(), 0, 0, _comm)
end

function po_write_forest_vtk(prefix)
    t8_forest_write_vtk(_forest, prefix)
end


function po_finalize()
    t8_global_productionf("finalizing\n")
    
    if !isnothing(_forest)
        t8_forest_unref(Ref(_forest))
    end

    sc_finalize()
end

end # module Pot8o
