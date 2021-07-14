function calculation (){
  const price = document.getElementById("item-price");
  price.addEventListener("keyup", () => {
    const add_tax_price = document.getElementById("add-tax-price");
    const  tax_price = Math.floor(price.value / 10);
    add_tax_price.innerHTML = tax_price;

    const profit = document.getElementById("profit");
    const get_money = price.value - tax_price;
    profit.innerHTML = get_money;
  });
};

window.addEventListener("load", calculation);