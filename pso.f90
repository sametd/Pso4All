module pso
  use config
  use types
  use objective
  use mersenne_twister
  implicit none
  contains
    subroutine pswarm(part,globalBest,lb,ub,vMax,vMin)
      type(Particle),dimension(Nparticle),intent(inout)::part
      type(Point),intent(inout)::globalBest
      real(dp),dimension(NPARAM),intent(in)::lb,ub,vMax,vMin
      real(dp),dimension(NPARAM)::randarray_pbest,randarray_globalBest
      integer::i,j,k,iter
      !!!!!!!!!!!!!!Main loop!!!!!!!!!!!!!!!
      do iter=1,maxIter
        !Calculation of objective func for each particle
        do j=1,Nparticle
          part(j)%cur%o = ObjectiveFunc(part(j)%cur%p)
!          print*, "Particle:",j,"Obj:",part(j)%cur%o
          !Update personal best
          if(part(j)%cur%o < part(j)%bst%o) then
            part(j)%bst%p = part(j)%cur%p
            part(j)%bst%o = part(j)%cur%o
          end if
          !Update global best
          if(part(j)%cur%o < globalBest%o) then
            globalBest%p = part(j)%cur%p
            globalBest%o = part(j)%cur%o
          end if
          !Scale the inertia of the particle
          part(j)%w = wMax - iter * ((wMax - wMin)/maxIter)
        end do
        !Update p and v
        do j=1,Nparticle
          do k=1,NPARAM
            randarray_pbest(k) = grnd()
            randarray_globalBest(k) = grnd()
          end do
          part(j)%v = part(j)%w * part(j)%v + c1 * randarray_pbest * (part(j)%bst%p - part(j)%cur%p) &
                                            + c2 * randarray_globalBest * (globalBest%p - part(j)%cur%p)
          !Limiting the velocity to keep particle inside of the search space
          do i=1,NPARAM
            if(part(j)%v(i) > vMax(i)) then
              part(j)%v(i)=vMax(i)
            end if
            if(part(j)%v(i) < vMin(i)) then
              part(j)%v(i)=vMin(i)
            end if
          end do
          !Update p
          part(j)%cur%p = part(j)%cur%p + part(j)%v
          !Limiting the position this time
          do i=1,NPARAM
            if(part(j)%cur%p(i) > ub(i)) then
              part(j)%cur%p(i) = ub(i)
            end if
            if(part(j)%cur%p(i) < lb(i)) then
              part(j)%cur%p(i) = lb(i)
            end if
          end do
        end do
        !end of the each particle
        write(*,*) "Iteration:",iter,"Gbest:",globalBest%o
      end do
      !end of the main loop
    end subroutine pswarm
end module pso