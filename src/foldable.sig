signature FOLDABLE_MIN = sig
  type 'a t
  val foldr : ('a * 'b -> 'b) -> 'b -> 'a t -> 'b
end

signature FOLDABLE = sig
  type 'a t
  val foldr : ('a * 'b -> 'b) -> 'b -> 'a t -> 'b
  val foldl : ('a * 'b -> 'b) -> 'b -> 'a t -> 'b
  val toList : 'a t -> 'a list
  val exists : ('a -> bool) -> 'a t -> bool
  val all : ('a -> bool) -> 'a t -> bool
end
