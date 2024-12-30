import MPI

MPI.Init()

comm  = MPI.COMM_WORLD
rank  = MPI.Comm_rank(comm)
nproc = MPI.Comm_size(comm)

println("My rank is ",rank," and I am 1 of ",nproc," processes.")

MPI.Barrier(comm)

MPI.Finalize()