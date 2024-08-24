const price = () => {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  if (!priceInput || !addTaxDom || !profitDom) return; // 全ての要素が存在することを確認

  const calculatePrice = () => {
    const inputValue = priceInput.value;
    const price = parseInt(inputValue);
    
    if (inputValue === '' || isNaN(price)) {
      // 入力値が空または数字でない場合は0を表示
      addTaxDom.innerHTML = '0';
      profitDom.innerHTML = '0';
    } else {
      // 販売手数料の計算（10%）
      const tax = Math.floor(price * 0.1);
      // 販売利益の計算
      const profit = price - tax;
      
      // 結果の表示
      addTaxDom.innerHTML = tax;
      profitDom.innerHTML = profit;
    }
  };

  priceInput.addEventListener("input", calculatePrice);
  calculatePrice(); // 初期表示のために一度実行
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);