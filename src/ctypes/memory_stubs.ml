(*
 * Copyright (c) 2013 Jeremy Yallop.
 *
 * This file is distributed under the terms of the MIT License.
 * See the file LICENSE for details.
 *)

(* Stubs for reading and writing memory. *)

(* A reference, managed by the garbage collector, to a region of memory in the
   C heap. *)
type managed_buffer

(* Allocate a region of stable memory managed by a custom block. *)
external allocate : int -> managed_buffer
  = "ctypes_allocate"

(* Obtain the address of the managed block. *)
external block_address : managed_buffer -> Ctypes_raw.voidp
  = "ctypes_block_address"

(* Read a C value from a block of memory *)
external read : 'a Primitives.prim -> Ctypes_raw.voidp -> 'a
  = "ctypes_read"

(* Write a C value to a block of memory *)
external write :  'a Primitives.prim -> 'a -> Ctypes_raw.voidp -> unit
  = "ctypes_write"

module Pointer =
struct
  external read : Ctypes_raw.voidp -> Ctypes_raw.voidp
    = "ctypes_read_pointer"

  external write : Ctypes_raw.voidp -> Ctypes_raw.voidp -> unit
  = "ctypes_write_pointer"
end

(* Copy [size] bytes from [src] to [dst]. *)
external memcpy : dst:Ctypes_raw.voidp -> src:Ctypes_raw.voidp -> size:int -> unit
  = "ctypes_memcpy"

(* Read a fixed length OCaml string from memory *)
external string_of_array : Ctypes_raw.voidp -> len:int -> string
  = "ctypes_string_of_array"
