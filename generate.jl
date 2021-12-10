using Pluto, PlutoSliderServer




root = @__DIR__
output = joinpath(root, "output")
input = joinpath(root, "input")

isdir(output) || mkdir(output)
isdir(input) || mkdir(input)


sample_html_path = Pluto.project_relative_path("frontend", "sample.html")
write(joinpath(output, "index.html"), let
    original = read(sample_html_path, String)

    cdn_root = "https://cdn.jsdelivr.net/gh/fonsp/Pluto.jl@$(string(Pluto.PLUTO_VERSION))/frontend"
    replace(
        replace(original,
            "href=\"./" => "href=\"$(cdn_root)/",
            "src=\"./" => "src=\"$(cdn_root)/",
        ),
        """href="sample/""" => """href="./""",
        ".jl\">" => ".html\">",
    )
end)

samples_dir = Pluto.project_relative_path("sample")

cp(samples_dir, input; force = true)

exclude = [
# "Basic.jl"
# "old_notebook_with_using.jl"
# "test1.jl"
# "test_embed_display.jl"
# "test_pkg_bubble.jl"
]
PlutoSliderServer.export_directory(input;
    Export_exclude = exclude,
    SliderServer_exclude = exclude,
    Export_output_dir = output,
    Export_baked_state = false,
    Export_baked_notebookfile = false
)