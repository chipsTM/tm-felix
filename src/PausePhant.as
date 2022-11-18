enum PausePhantAnimation {
    Idle,
    Love,
    Bedge,
    Shy,
    Move,
    No
};

class PausePhant : Animation {
    vec2 position;
    int scaleFactor = 1;
    uint animationTick = 0;
    PausePhantAnimation curAnimation = PausePhantAnimation::Move;
    UI::Texture@ atlas;
    int sprite_width = 128;
    int sprite_height = 128;
    int loops = 0;
    int times = 10;
    int curXDir = -1;
    int curYDir = -1;

    dictionary aniFrames = {
        { tostring(PausePhantAnimation::Idle), 14},
        { tostring(PausePhantAnimation::Love), 9},
        { tostring(PausePhantAnimation::Bedge), 6},
        { tostring(PausePhantAnimation::Shy), 13},
        { tostring(PausePhantAnimation::Move), 4},
        { tostring(PausePhantAnimation::No), 11}
    };

    PausePhant(UI::Texture@ at) {
        @atlas = @at;
        position = vec2(Math::Rand(0, g_width), Math::Rand(0, g_height));
    }

    void Render() override {
        auto drawlist = UI::GetForegroundDrawList();

        UI::PushStyleColor(UI::Col::WindowBg, vec4(0,0,0,0));
        UI::PushStyleColor(UI::Col::Border, vec4(0,0,0,0));
        int windowFlags = UI::WindowFlags::NoTitleBar | UI::WindowFlags::NoCollapse | UI::WindowFlags::AlwaysAutoResize | UI::WindowFlags::NoDocking | UI::WindowFlags::NoInputs;
        UI::Begin("PausePhant", windowFlags);
        
        drawlist.AddImage(atlas, position, vec2(sprite_width*scaleFactor*curXDir,sprite_height*scaleFactor), 0xFFFFFFFF, vec4(sprite_width*animationTick, sprite_height*curAnimation, sprite_width, sprite_height));

        uint frames = uint(aniFrames[tostring(curAnimation)]);
        if (g_dt >= 150) {
            if (position.x >= g_width - sprite_width) {
                curXDir = -1;
            } else if (position.x <= sprite_width) {
                curXDir = 1;
            }

            if (position.y >= g_height - sprite_height) {
                curYDir = -1;
            } else if (position.y <= sprite_height) {
                curYDir = 1;
            }

            if (curAnimation == PausePhantAnimation::Move) {
                position.x += curXDir * 3;
                position.y += curYDir * 1;
            }

            if (animationTick >= frames - 1) {
                animationTick = 0;
            } else {
                animationTick += 1;
            }
            g_dt = 0;
            if (loops >= times * frames - 1) {
                if (curAnimation == PausePhantAnimation::Idle) {	
                    curAnimation = PausePhantAnimation(Math::Rand(1,6));
                    loops = 0;
                    switch (curAnimation) {
                        case PausePhantAnimation::Love:
                            times = 1;
                            break;
                        case PausePhantAnimation::Bedge:
                            times = Math::Rand(10,31);
                            break;
                        case PausePhantAnimation::Shy:
                            times = 1;
                            break;
                        case PausePhantAnimation::No:
                            times = 1;
                            break;
                        case PausePhantAnimation::Move:
                            times = Math::Rand(5, 21);
                            break;
                        default:
                            // should never reach
                            break;
                    }
                    curYDir = 0;
                    while (curYDir == 0) {
                        curYDir = Math::Rand(-1,2);
                    }
                } else {
                    curAnimation = PausePhantAnimation::Idle;
                    loops = 0;
                    times = Math::Rand(1,4);
                }
            } else {
                loops += 1;
            }
        }

        UI::End();
        UI::PopStyleColor(2);
    }
}