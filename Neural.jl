# I'm going to build my own neural net from scratch because why not

"""
    train_neural(training_data, layers, input_layer;
                 iterations, seed, verbose, graphic)

```
iterations = 100
seed = 1337
verbose = true
graphic = true
```
`training_data` -> game states basically
`layers` -> [number of neurons layer 1, layer 2, etc.] (excludes input layer)
`inpu_layer` -> size of the input layer
`iterations` -> number of times to loop (and improve)
`verbose` -> print to console
`graphic` -> draw pretty graphs
"""
function train_neural(
    training_data::Array{Array{Any, 1}, 1},
    layers::Array{Int64, 1},
    input_layer::Int64;
    iteratations = 100,
    seed = 1337,
    verbose = true,
    graphic = true,
)

    # convert game state to useful training data
    decompiled_training = decompile_state(training_data)

    # Set up neurons with random values
    Random.seed!(seed)
    neurons = []
    for i in layers
        push!(neurons, [])
        for x in 1:layers[i]
            push!(neurons[i], [rand(1:input_layer)])

end # function
