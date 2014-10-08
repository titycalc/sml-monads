functor Applicative3(Applicative3Min : APPLICATIVE3_MIN)
        :> APPLICATIVE3 where type ('y, 'z, 'a) t
                                  = ('y, 'z, 'a) Applicative3Min.t = struct
  open Applicative3Min

  infix 4 <$> <*>

  structure Functor3Min = struct
    type ('y, 'z, 'a) t = ('y, 'z, 'a) t
    fun fmap (f, x) = pure f <*> x
  end

  structure Functor3 = Functor3(Functor3Min)

  open Functor3

  fun curry f x y = f(x, y)
  fun curry3 f x y z = f(x, y, z)
  fun liftA f x = f <$> x
  fun liftA2 f (x, y) = curry f <$> x <*> y
  fun liftA3 f (x, y, z) = curry3 f <$> x <*> y <*> z
  fun <**> (x, y) = y <*> x
  fun *> (x, y) = curry (fn (x0, y0) => y0) <$> x <*> y
  fun <* (x, y) = curry (fn (x0, y0) => x0) <$> x <*> y
end

functor Applicative2(Applicative2Min : APPLICATIVE2_MIN)
        :> APPLICATIVE2 where type ('z, 'a) t
                                  = ('z, 'a) Applicative2Min.t = struct
  structure Applicative3 = Applicative3(struct
                                         type ('y, 'z, 'a) t
                                              = ('z, 'a) Applicative2Min.t
                                         val pure = Applicative2Min.pure
                                         val <*> = Applicative2Min.<*>
                                         end)

  open Applicative3
  open Applicative2Min
  structure Functor2 = Functor3ToFunctor2(Functor3)
end

functor Applicative(ApplicativeMin : APPLICATIVE_MIN)
        :> APPLICATIVE where type 'a t
                                  = 'a ApplicativeMin.t = struct
  structure Applicative3 = Applicative3(struct
                                         type ('y, 'z, 'a) t
                                              = 'a ApplicativeMin.t
                                         val pure = ApplicativeMin.pure
                                         val <*> = ApplicativeMin.<*>
                                         end)

  open Applicative3
  open ApplicativeMin
  structure Functor = Functor3ToFunctor(Functor3)
end
