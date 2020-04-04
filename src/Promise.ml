include Js.Promise

let map f promise = promise |> then_ (fun x -> resolve (f x))

let return = resolve

module O = struct
  let (>>|) x f = map f x

  let (>>=) x f = then_ f x
end

module Result = struct
  let bind fn promise =
    let open Js.Promise in
    promise
    |> then_ (function
         | Error e -> Error e |> resolve
         | Ok payload -> fn payload)

  let map f x =
    x
    |> then_ (fun x ->
           resolve
             ( match x with
             | Error _ as e -> e
             | Ok x -> Ok (f x) ))

  let return x = return (Ok x)

  module O = struct
    let (>>=) x f = bind f x

    let (>>|) x f = map f x
  end
end
