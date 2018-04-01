program main
  use pso
  implicit none
  type(Particle),dimension(Nparticle)::part
  type(Point)::globalBest
  real(dp),dimension(NPARAM)::lb,ub,vMax,vMin,randarray
  real(dp),parameter::infinity = 1.e100_dp
  integer::i,j
  integer::clock,seed
  !Arranging seed for the mersenne
  call SYSTEM_CLOCK(COUNT=clock)
  seed = clock
  call init_genrand(seed)
  !First lower and upper bounds
  do i=1,NPARAM
   lb(i) = -10.
   ub(i) = 10.
  end do
  !Arrange velocity max and min
  vMax = (ub-lb)
  do i=1,NPARAM
    vMax(i) = vMax(i) * 0.2
    vMin(i) = -vMax(i)
  end do
  !Initialization of particles
  do i=1,Nparticle
    do j=1,NPARAM
      randarray(j) = grnd()
    end do
    part(i)%cur%p = ((ub - lb) * randarray) + lb
    do j=1,NPARAM
      part(i)%v(j) = 0.
      part(i)%bst%p(j) = 0.
    end do
    part(i)%bst%o = infinity
  end do
!Initialization of global best
  do i=1,NPARAM
    globalBest%p(i) = 0.
  end do
  globalBest%o = infinity
!Run pso
  call pswarm(part,globalBest,lb,ub,vMax,vMin)
  write(*,*) "Final Parameters:", globalBest%p

end program main