module Pot8o

export po_initialize
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

function po_initialize()
    # Initialize MPI. This has to happen before we initialize sc or t8code.
    mpiret = MPI.Init()

    # We will use MPI_COMM_WORLD as a communicator.
    comm = MPI.COMM_WORLD

    # Initialize the sc library, has to happen before we initialize t8code.
    sc_init(comm, 1, 1, C_NULL, SC_LP_ESSENTIAL)
    # Initialize t8code with log level SC_LP_PRODUCTION. See sc.h for more info on the log levels.
    t8_init(SC_LP_PRODUCTION)
end

function po_finalize()
    t8_global_productionf("finalizing\n")
    sc_finalize()
end

end # module Pot8o
