require './pomodoro.rb'

describe Pomodoro do
  it "should last 25 minutes if no other duration specified" do
    subject.duration.should == 25
  end
  it "should be possible to create pomodoros of any duration" do
    pomodoro = Pomodoro.new(35)
    pomodoro.duration.should == 35
  end

  describe "just created" do
    it "should be stopped" do
      subject.should be_stopped
    end
    it "should not have interruptions" do
      subject.interruptions.should == 0
    end
    it "should not be posible to stop it" do
      subject.stop.should be_false
      subject.interruptions.should == 0
    end
    it "should not be finished even if there is no more time" do
      subject.remaining_time = 0
      subject.should_not be_finished
    end    
  end
  
  describe "started" do
    subject{ Pomodoro.new.tap{ |p| p.start } }
    it "should count interruptions" do
      expect { subject.stop }.to change(subject, :interruptions).from(0).to(1)
      subject.resume
      expect { subject.stop }.to change(subject, :interruptions).from(1).to(2)
    end
    it "should be finished if it have no more time" do
      subject.remaining_time = 0
      subject.should be_finished
    end
    describe "after being reset" do
      subject do
        Pomodoro.new.tap{ |p|
          p.remaining_time = 2
          p.interruptions = 4
        }
      end
      it "should start again the count down" do
        expect{ subject.reset }.to change(subject, :remaining_time).from(2).to(25)
      end
      it "should clear its interruptions" do
        expect{ subject.reset }.to change(subject, :interruptions).from(4).to(0)
      end
    end
  end  

  describe "stoped" do
    subject{ Pomodoro.new.tap{ |p| p.start && p.stop } }
    it "cant be stoped until it is resumed" do
      subject.stop.should be_false
      subject.interruptions.should == 1
    end
  end 
end