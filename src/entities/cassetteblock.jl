module CassetteBlock

using ..Ahorn, Maple

# Index 2 and 3 doesn't appear in the game
# Everest makes them function, and recolors index 2
colorNames = Dict{Int, String}(
    0 => "Blue",
    1 => "Rose",
    # 2 => "Amethyst", 
    2 => "Emerald",
    3 => "Marigold"
)

placements = Dict{String, Ahorn.EntityPlacement}(
    "Cassette Block ($index - $color)" => Ahorn.EntityPlacement(
        Maple.CassetteBlock,
        "rectangle",
        Dict{String, Any}(
            "index" => index,
        )
    ) for (index, color) in colorNames
)

function editingOptions(entity::Maple.Entity)
    if entity.name == "cassetteBlock"
        return true, Dict{String, Any}(
            "index" => [0, 1, 2, 3]
        )
    end
end

function minimumSize(entity::Maple.Entity)
    if entity.name == "cassetteBlock"
        return true, 16, 16
    end
end

function resizable(entity::Maple.Entity)
    if entity.name == "cassetteBlock"
        return true, true, true
    end
end

function selection(entity::Maple.Entity)
    if entity.name == "cassetteBlock"
        x, y = Ahorn.entityTranslation(entity)

        width = Int(get(entity.data, "width", 8))
        height = Int(get(entity.data, "height", 8))

        return true, Ahorn.Rectangle(x, y, width, height)
    end
end

colors = Dict{Integer, Ahorn.colorTupleType}(
    1 => (240, 73, 190, 1) ./ (255.0, 255.0, 255.0, 1.0),
    # 2 => (197, 71, 203, 1) ./ (255.0, 255.0, 255.0, 1.0),
    2 => (28, 80, 51, 1) ./ (255.0, 255.0, 255.0, 1.0),
    3 => (182, 128, 38, 1) ./ (255.0, 255.0, 255.0, 1.0)
)

defaultColor = (73, 170, 240, 1) ./ (255.0, 255.0, 255.0, 1.0)
borderMultiplier = (0.9, 0.9, 0.9, 1)

# Draw tinted once tinted drawing is supported
function render(ctx::Ahorn.Cairo.CairoContext, entity::Maple.Entity, room::Maple.Room)
    if entity.name == "cassetteBlock"
        x = Int(get(entity.data, "x", 0))
        y = Int(get(entity.data, "y", 0))

        width = Int(get(entity.data, "width", 32))
        height = Int(get(entity.data, "height", 32))

        index = Int(get(entity.data, "index", 0))
        color = get(colors, index, defaultColor)
        Ahorn.drawRectangle(ctx, 0, 0, width, height, color, color .* borderMultiplier)

        return true
    end

    return false
end

end