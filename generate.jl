using Pluto, PlutoSliderServer




root = @__DIR__
output = joinpath(root, "output")
input = joinpath(root, "input")

# isdir(output) || mkdir(output)
# isdir(input) || mkdir(input)




samples_dir = Pluto.project_relative_path("sample")

cp(samples_dir, input; force = true)

PlutoSliderServer.export_directory(input;
    Export_exclude = [
        "Basic.jl"
        "old_notebook_with_using.jl"
        "test1.jl"
        "test_embed_display.jl"
        "test_pkg_bubble.jl"
    ],
    Export_output_dir = output,
    Export_baked_state = false,
    Export_baked_notebookfile = false
)