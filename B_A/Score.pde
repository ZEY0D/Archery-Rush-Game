
// Score Class
class Score {
  int remainingArrows;
  int shotBalloons;

  Score(int remainingArrows, int shotBalloons) {
    this.remainingArrows = remainingArrows;
    this.shotBalloons = shotBalloons;
  }  
  int calculateScore() {
    return (remainingArrows + 1) * shotBalloons;
  }
}

// reload , transfer messages 
