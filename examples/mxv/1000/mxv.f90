subroutine mxv_doidoj ( a, x, y)

!*****************************************************************************80
!
!! MXV_DOIDOJ computes y = A * x, using DO I, DO J loops.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license. 
!
!  Modified:
!
!    17 May 2008
!
!  Author:
!
!    John Burkardt
!
!  Parameters:
!
!    Input, integer ( kind = 4 ) M, N, the number of rows and columns
!    of the matrix.
!
!    Input, real ( kind = 8 ) A(M,N), the matrix.
!
!    Input, real ( kind = 8 ) X(N), the vector to be multiplied.
!
!    Output, real ( kind = 8 ) Y(M), the product vector.
!
!    Output, real ( kind = 8 ) CPU_SECONDS, the elapsed CPU time.
!
  implicit none

  integer ( kind = 4 ) m
  integer ( kind = 4 ) n

  real ( kind = 4 ) a(1000,1000)
  integer ( kind = 4 ) i
  integer ( kind = 4 ) j
  real ( kind = 4 ) x(1000)
  real ( kind = 4 ) y(1000)

  m = 1000
  n = 1000

  !$omp target
  !$omp parallel do simd simdlen(100)
  do i = 1, m
    y(i) = 0.0
    do j = 1, n
      y(i) = y(i) + a(i,j) * x(j)
    end do
  end do
  !$omp end parallel do simd
  !$omp end target

  return
end

program main
    implicit none

    real(kind=4) :: a(1000,1000)
    real(kind=4) :: x(1000)
    real(kind=4) :: y(1000)

    call mxv_doidoj(a, x, y)
end program main