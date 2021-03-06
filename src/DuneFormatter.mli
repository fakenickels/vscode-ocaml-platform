type t

val create : unit -> t

(** register formatters for dune, dune-project, and dune-workspace files *)
val register : t -> Toolchain.resources -> unit

(** dispose registered formatters *)
val dispose : t -> unit
