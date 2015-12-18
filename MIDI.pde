MidiOutput output;
MidiInput input;

int ch_s = 0;
int pit_s = 60;
int vel_s = 100;

int program_s;
int device_s;
int h=0;//押された／離された音
float pedal=0;//ペダルの踏まれ具合

void setup_Midi() {
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

  output.sendProgramChange(program_s);  //プログラムチェンジ
  output.sendPitchBend(ch_s, 8192 );  //ピッチベンド-1度基準を作らないといけない．
  output.sendNoteOn(ch_s, 60, vel_s);  //ノートオン
  output.sendPitchBend(ch_s, 0 );   //ピッチベンド
  output.sendController(ch_s, 11, vel_s );  //エクスプレッション
  output.sendNoteOff(ch_s, pit_s, vel_s);   //NoteOff
}

void noteOnReceived(Note note) {
  h=note.getPitch();
  println("Note on: " + scaleName[h]+ ", velocity: " + note.getVelocity());
  if (note.getVelocity()>0) {
    drawCrystal(h-21);

    keyingCount++;
    simult_keying_count++;
    isKeying[(h-21)%12][(h-21)/12]=true;

    if (isSilent) {
      silent_end_time=month()*1339200+31*day()*111600+hour()*1200+minute()*60+second();

      int silent_time=silent_end_time-silent_start_time;

      if (silent_time>2) {

        try {
          ArrayList<String> t = new ArrayList<String>();
          String s=null;
          BufferedReader r=createReader("MIDIdata/silenttime.txt");

          while ((s=r.readLine())!=null) {
            t.add(s);
          }

          t.add(str(silent_time));

          saveStrings("MIDIdata/silenttime.txt", (String[])t.toArray(new String[0]));

          save_state=true;
          isWriting_start_time=false;
        }
        catch(IOException e) {
        }
      }
    }
  }
}

void noteOffReceived(Note note) {
  println("Note off: " + scaleName[note.getPitch()]);
}

void controllerChangeReceived(Controller controller) {
  println("CC: " + controller.getCC() + ", value: " + controller.getValue());
  pedal=controller.getValue();
}