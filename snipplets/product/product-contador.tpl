<div class="visitor-counter-box">
    <div class="visitor-text">
        <span class="visitor-icon">
            <img style="height:20px; vertical-align: middle; margin-right: 5px; margin-top: -6px;" src="https://images.emojiterra.com/google/noto-emoji/unicode-16.0/color/svg/1f525.svg">
        </span>
        <span id="view-count">36</span> pessoas visualizando agora
    </div>
</div>

<script>
  const viewsByHour = {
    0: 18, 1: 15, 2: 12, 3: 10, 4: 8, 5: 10, 6: 15, 7: 22, 8: 35, 
    9: 42, 10: 48, 11: 52, 12: 58, 13: 55, 14: 60, 15: 65, 16: 70, 
    17: 68, 18: 72, 19: 75, 20: 70, 21: 65, 22: 50, 23: 35
  };

  function updateViewCount() {
    const viewCount = document.getElementById('view-count');
    if (viewCount) {
      const now = new Date();
      const hour = now.getHours();
      const minute = now.getMinutes();
      
      let baseCount = viewsByHour[hour] || 36;
      const minuteVariation = Math.floor((minute / 60) * 5);
      let count = baseCount + minuteVariation;
      const randomVariation = Math.floor(Math.random() * 4) - 2;
      count = Math.max(8, count + randomVariation);
      
      // Isso agora altera apenas o número, preservando a imagem ao lado
      viewCount.textContent = count;
    }
  }

  updateViewCount();
  setInterval(updateViewCount, 60000);
</script>