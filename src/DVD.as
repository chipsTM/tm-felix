class DVD : Animation {
    int scaleFactor = 1;
    UI::Texture@ atlas;
    int sprite_width = 192;
    int sprite_height = 86;
    int curXDir = 1;
    int curYDir = 1;
    uint color;

    DVD(UI::Texture@ at) {
        @atlas = @at;
        position = vec2(Math::Rand(0, g_width-sprite_width*scaleFactor), Math::Rand(0, g_height-sprite_height*scaleFactor));
        generateColor();
    }

    void generateColor() {
        int r = Math::Rand(0, 256);
        int g = Math::Rand(0, 256);
        int b = Math::Rand(0, 256);
        int a = 0xFF;
        color = (r << 24) | (g << 16) | (b << 8) | (a);
    }

    void Render() override {
        auto drawlist = UI::GetForegroundDrawList();

        UI::PushStyleColor(UI::Col::WindowBg, vec4(0,0,0,0));
        UI::PushStyleColor(UI::Col::Border, vec4(0,0,0,0));
        int windowFlags = UI::WindowFlags::NoTitleBar | UI::WindowFlags::NoCollapse | UI::WindowFlags::AlwaysAutoResize | UI::WindowFlags::NoDocking | UI::WindowFlags::NoInputs;
        UI::Begin("DVD", windowFlags);

        drawlist.AddImage(atlas, position, vec2(sprite_width*scaleFactor,sprite_height*scaleFactor), color, vec4(0, 0, sprite_width, sprite_height));

        if (g_dt >= 100) {
            if (position.x >= g_width - sprite_width) {
                curXDir = -1;
                generateColor();
            } else if (position.x <= 0) {
                curXDir = 1;
                generateColor();
            }

            if (position.y >= g_height - sprite_height) {
                curYDir = -1;
                generateColor();
            } else if (position.y <= 0) {
                curYDir = 1;
                generateColor();
            }

            position.x += curXDir * 1;
            position.y += curYDir * 1;
        }

        UI::End();
        UI::PopStyleColor(2);
    }
}