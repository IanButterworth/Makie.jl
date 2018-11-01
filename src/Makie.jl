module Makie

using AbstractPlotting
using GeometryTypes, Colors, ColorVectorSpace, StaticArrays
import IntervalSets
using IntervalSets: ClosedInterval, (..)
using ImageCore
import FileIO
using LinearAlgebra, Statistics
using Base64

module ContoursHygiene
    import Contour
end
using .ContoursHygiene
const Contours = ContoursHygiene.Contour

using Primes
using Base.Iterators: repeated, drop
using FreeType, FreeTypeAbstraction, UnicodeFun
using PlotUtils, Showoff
using Base: RefValue
import Base: push!, isopen, show

for name in names(AbstractPlotting)
    @eval import AbstractPlotting: $(name)
    @eval export $(name)
end

# Unexported names
using AbstractPlotting: @info, @log_performance, @warn, NativeFont, Key, @key_str

export (..), GLNormalUVMesh
# conflicting identifiers
using AbstractPlotting: Text, volume, VecTypes
using GeometryTypes: widths
export widths, decompose


const has_ffmpeg = Ref(false)

function __init__()
    has_ffmpeg[] = try
        success(`ffmpeg -h`)
    catch
        false
    end
end

function logo()
    FileIO.load(joinpath(@__DIR__, "..", "docs", "src", "assets", "logo.png"))
end

include("makie_recipes.jl")
include("utils.jl")
include("output.jl")
include("video_io.jl")


end
