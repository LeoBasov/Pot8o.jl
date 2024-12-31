using Pot8o

po_initialize()
po_read_msh_file("examples/FreeCAD_to_t8code_example", 3)
po_write_forest_vtk("test")
po_finalize()
