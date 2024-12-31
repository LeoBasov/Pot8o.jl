using Pot8o

po_initialize()
po_read_msh_file("examples/cylinder_flow/box_cylinder", 3)
po_write_forest_vtk("box_cylinder")
po_finalize()