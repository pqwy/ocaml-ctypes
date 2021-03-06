(*
 * Copyright (c) 2014 Jeremy Yallop.
 *
 * This file is distributed under the terms of the MIT License.
 * See the file LICENSE for details.
 *)

(** Operations for generating C bindings stubs. *)

module type FOREIGN =
sig
  type 'a fn
  val foreign : string -> ('a -> 'b) Ctypes.fn -> ('a -> 'b) fn
end

module type BINDINGS = functor (F : FOREIGN with type 'a fn = unit) -> sig end

val write_c : Format.formatter -> prefix:string -> (module BINDINGS) -> unit
(** [write_c fmt ~prefix bindings] generates C stubs for the functions bound
    with [foreign] in [bindings].  The stubs are intended to be used in
    conjunction with the ML code generated by {!write_ml}.

    The generated code uses definitions exposed in the header file
    [cstubs_internals.h].
*)

val write_ml : Format.formatter -> prefix:string -> (module BINDINGS) -> unit
(** [write_ml fmt ~prefix bindings] generates ML bindings for the functions
    bound with [foreign] in [bindings].  The generated code conforms to the
    {!FOREIGN} interface.

    The generated code uses definitions exposed in the module
    [Cstubs_internals]. *)

