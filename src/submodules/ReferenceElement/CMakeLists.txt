# This file is a part of easifem-base
# (c) 2021, Vikas Sharma, Ph.D.
# All right reserved
#
# log
# 2/03/2021 this file was created
# 2 March 2021 new file names were added
#-----------------------------------------------------------------------

set(src_path "${CMAKE_CURRENT_LIST_DIR}/src/")
target_sources(
  ${PROJECT_NAME} PRIVATE
  ${src_path}/ReferenceElement_Method@Constructor.f90
  ${src_path}/ReferenceElement_Method@IO.f90
  ${src_path}/ReferenceElement_Method@Geometry.f90
  ${src_path}/ReferenceElement_Method@VTK.f90
  ${src_path}/ReferencePoint_Method@Methods.f90
  ${src_path}/ReferenceLine_Method@Methods.f90
  ${src_path}/ReferenceTriangle_Method@Methods.f90
  ${src_path}/ReferenceQuadrangle_Method@Methods.f90
  ${src_path}/ReferenceTetrahedron_Method@Methods.f90
  ${src_path}/ReferenceHexahedron_Method@Methods.f90
  ${src_path}/ReferencePrism_Method@Methods.f90
  ${src_path}/ReferencePyramid_Method@Methods.f90
)