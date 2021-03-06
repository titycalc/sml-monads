structure SMLMonadsOption :> SML_MONADS_OPTION =

let structure Origin = struct
      type 'a t = 'a option
      fun return x = SOME x
      fun >>=(SOME x, f) = f x
        | >>= _ = NONE
      fun mzero () = NONE
      fun mplus(NONE, x) = x
        | mplus(x, _) = x
    end

    structure MonadPlus = MonadPlus(Origin)
in struct
      open MonadPlus
    end
end

functor SMLMonadsOptionT(Monad : MONAD)
        :> SML_MONADS_OPTION_T where type 'a M.t = 'a Monad.t = struct
type 'a t = 'a option Monad.t
structure M = Monad
structure O = SMLMonadsOption
fun run m = m
fun lift m = M.fmap(SOME, m)
fun return x = M.return(SOME x)
fun >>=(m, f) = M.>>=(m, fn SOME x => f x
                       | NONE => M.return NONE)
fun mzero () = M.return NONE
fun mplus(m, k) = M.>>=(m, fn x => M.>>=(k, fn y => M.return(O.mplus(x, y))))
structure MonadPlus = MonadPlus(struct
                                 type 'a t = 'a t
                                 val return = return
                                 val >>= = >>=
                                 val mzero = mzero
                                 val mplus = mplus
                                 end)
open MonadPlus
end
