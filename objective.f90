module objective
  use config
  implicit none
  contains
    real(dp) function ObjectiveFunc(x) Result(func_val)
      real(dp),dimension(NPARAM),intent(in)::x
      func_val = sum(x*x)
    end function ObjectiveFunc
end module objective