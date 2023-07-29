document.getElementById("hidden_box").style.display ="none";

function clickBtn1() {
  const hidden_box = document.getElementById("hidden_box");
  if(hidden_box.style.display=="block"){
    hidden_box.style.display ="none";
  }else{
    hidden_box.style.display ="block";    
  }
}
