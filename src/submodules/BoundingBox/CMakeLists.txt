# This file is a part of easifem-base
# (c) 2021, Vikas Sharma, Ph.D.
# All right reserved
#
# log
# 23/02/2021 this file was created
#-----------------------------------------------------------------------

set(src_path "${CMAKE_CURRENT_LIST_DIR}/src/")
target_sources(
  ${PROJECT_NAME} PRIVATE
  ${src_path}/BoundingBox_Method@Constructor.f90
  ${src_path}/BoundingBox_Method@setMethod.f90
  ${src_path}/BoundingBox_Method@getMethod.f90
)