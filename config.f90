module config
  implicit none
  integer,parameter::dp = SELECTED_REAL_KIND(15, 307)
  integer,parameter::NPARAM = 10
  integer,parameter::Nparticle = 100
  integer,parameter::maxIter = 500
  real(dp),parameter::wMax = 0.9 !inertia max
  real(dp),parameter::wMin = 0.2 !inertia min
  real(dp),parameter::c1 = 2 !tendency to personal best
  real(dp),parameter::c2 = 2 !tendency to global best
end module config