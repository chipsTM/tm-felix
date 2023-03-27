string cur_selection = "Felix";
bool isSettingsOpen = false;

[Setting hidden]
Character g_char = Character::ArachFelixWhite;


[SettingsTab name="Character Selection"]
void RenderCharacterSettings() {
    isSettingsOpen = true;
    if (UI::BeginCombo("Character", cur_selection)) {
        if(UI::Selectable("Felix", g_char == Character::ArachFelixWhite)){
            g_char = Character::ArachFelixWhite;
            cur_selection = "Felix";
            SelectCharacter();
        }
        if(UI::Selectable("Prometheus", g_char == Character::ArachFelixBlack)){
            g_char = Character::ArachFelixBlack;
            cur_selection = "Prometheus";
            SelectCharacter();
        }
        if(UI::Selectable("Steve", g_char == Character::ArachFelixOrange)){
            g_char = Character::ArachFelixOrange;
            cur_selection = "Steve";
            SelectCharacter();
        }
        if(UI::Selectable("Gerard", g_char == Character::ArachFelixSiamese)){
            g_char = Character::ArachFelixSiamese;
            cur_selection = "Gerard";
            SelectCharacter();
        }
        if(UI::Selectable("PausePhant", g_char == Character::PausePhant)){
            g_char = Character::PausePhant;
            cur_selection = "PausePhant";
            SelectCharacter();
        }
        if(UI::Selectable("DVD Logo", g_char == Character::DVD)){
            g_char = Character::DVD;
            cur_selection = "DVD Logo";
            SelectCharacter();
        }
        if(UI::Selectable("Felix Original", g_char == Character::FelixOriginal)){
            g_char = Character::FelixOriginal;
            cur_selection = "Felix Original";
            SelectCharacter();
        }
        UI::EndCombo();
    }
    vec2 settingsWinPos = UI::GetWindowPos();
    g_anim.position.x = settingsWinPos.x + 100;
    g_anim.position.y = settingsWinPos.y + 100;
}