let itemIndex = 1;

function addItemFields() {
  const container = document.getElementById('items-container');
  const newItem = document.createElement('div');
  newItem.classList.add('item-fields');
  newItem.setAttribute('data-item-index', itemIndex);

  newItem.innerHTML = `
        <label for="name_${itemIndex}">Item Name:</label>
        <input class="item-input" type="text" name="items[${itemIndex}][name]" id="name_${itemIndex}" required><br>

        <label for="quantity_${itemIndex}">Quantity:</label>
        <input class="item-input" type="number" name="items[${itemIndex}][quantity]" id="quantity_${itemIndex}" min="1" required><br>

        <label for="price_${itemIndex}">Price:</label>
        <input class="item-input" type="number" step="0.01" name="items[${itemIndex}][price]" id="price_${itemIndex}" min="0" required><br>

        <label for="imported_${itemIndex}">Imported:</label>
        <select class="item-input" name="items[${itemIndex}][imported]" id="imported_${itemIndex}" required>
            <option value="false">No</option>
            <option value="true">Yes</option>
        </select><br>

        <label for="tax_exempt_${itemIndex}">Tax Exempt:</label>
        <select class="item-input" name="items[${itemIndex}][tax_exempt]" id="tax_exempt_${itemIndex}" required>
            <option value="false">No</option>
            <option value="true">Yes</option>
        </select><br>

        <button type="button" onclick="removeItemFields(${itemIndex})">Remove</button>
      `;

  container.appendChild(newItem);
  itemIndex++;
}

function removeItemFields(index) {
  const itemToRemove = document.querySelector(`[data-item-index="${index}"]`);
  itemToRemove.remove();
}