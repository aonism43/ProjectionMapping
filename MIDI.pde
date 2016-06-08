class MIDI {
  private MidiOutput output;
  private MidiInput input;

  private int ch_s = 0;
  private int pit_s = 60;
  private int vel_s = 100;

  private int program_s;
  private int device_s;
  
  private float pedal = 0;//ペダルの踏まれ具合

  private String[] scale_name={//ノート番号から音名を取得する配列
    ""  , ""   , ""   , ""   , ""  , ""  , ""   , ""  , ""   , ""  , 
    ""  , ""   , ""   , ""   , ""  , ""  , ""   , ""  , ""   , ""  , 
    ""  , "A0" , "A#0", "B0 ", 
    "C0", "C#0", "D0" , "D#0", "E0", "F0", "F#0", "G0", "G#0", "A0", "A#0", "B0", 
    "C1", "C#1", "D1" , "D#1", "E1", "F1", "F#1", "G1", "G#1", "A1", "A#1", "B1", 
    "C2", "C#2", "D2" , "D#2", "E2", "F2", "F#2", "G2", "G#2", "A2", "A#2", "B2", 
    "C3", "C#3", "D3" , "D#3", "E3", "F3", "F#3", "G3", "G#3", "A3", "A#3", "B3", 
    "C4", "C#4", "D4" , "D#4", "E4", "F4", "F#4", "G4", "G#4", "A4", "A#4", "B4", 
    "C5", "C#5", "D5" , "D#5", "E5", "F5", "F#5", "G5", "G#5", "A5", "A#5", "B5", 
    "C6", "C#6", "D6" , "D#6", "E6", "F6", "F#6", "G6", "G#6", "A6", "A#6", "B6", 
    "C7"
  };

  MIDI(){
    device_s = 0;
    program_s = 0;

    println("Midi input device list:");
    println(RWMidi.getInputDeviceNames());
    input = RWMidi.getInputDevices()[0].createInput(this);

    println("Midi output device list:");
    println(RWMidi.getOutputDeviceNames());
    output = RWMidi.getOutputDevices()[1].createOutput();

    println("Input: " + input.getName());
    println("Output: " + output.getName());

    output.sendProgramChange(program_s);    //プログラムチェンジ
    output.sendPitchBend(ch_s, 8192 );      //ピッチベンド：1度基準を作らないといけない．
    output.sendNoteOn(ch_s, 60, vel_s);     //ノートオン
    output.sendPitchBend(ch_s, 0 );         //ピッチベンド
    output.sendController(ch_s, 11, vel_s );//エクスプレッション
    output.sendNoteOff(ch_s, pit_s, vel_s); //NoteOff
  }

  public String get_scale_name(int n){
    return this.scale_name[n];
  }

  public void noteOnReceived(Note note) {
    int h    = note.getPitch();
    int velo = note.getVelocity();
    
    println("Note on: " + this.scale_name[h]+ ", velocity: " + velo);
    
    if (velo > 0) {
      snow.create_crystal(h-21);

      simult_keying_count++;
      isKeying[(h-21)%12][(h-21)/12] = true;
    }
  }

  public void noteOffReceived(Note note) {
    println("Note off: " + scale_name[note.getPitch()]);
  }

  void controllerChangeReceived(Controller controller) {
    println("CC: " + controller.getCC() + ", value: " + controller.getValue());
    pedal = controller.getValue();
  }
}