int silent_start_time=0;
int silent_end_time=0;

void GatheringMIDI() {
  if (simult_keying_count==0) isSilent=true;
  else isSilent=false;


  if (isSilent) {
    if (!(isWriting_start_time)) {
      silent_start_time=month()*1339200+31*day()*111600+hour()*1200+minute()*60+second();
    }
    isWriting_start_time=true;

    fill(255);
    text("silentTime："+str(month()*1339200+31*day()*111600+hour()*1200+minute()*60+second()-silent_start_time), mouseX+5, mouseY);
  } else {
    save_state=false;
  }
  fill(255);
  text(str(isSilent)+"：isSilent", mouseX+5, mouseY+10);
  text(str(isWriting_start_time)+"：isWriting_start_time", mouseX+5, mouseY+20);
}