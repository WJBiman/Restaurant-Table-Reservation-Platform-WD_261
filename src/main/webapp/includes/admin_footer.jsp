</main>
</div> <!-- Close main-content -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        if(typeof flatpickr !== 'undefined') {
            flatpickr("input[type=date]", {
                dateFormat: "Y-m-d",
                disableMobile: true
            });
            flatpickr("input[type=time]", {
                enableTime: true,
                noCalendar: true,
                dateFormat: "H:i",
                time_24hr: true,
                disableMobile: true
            });
        }

        // Custom Select Logic for Admin Panel
        document.querySelectorAll('select.form-select').forEach(function(select) {
            select.style.display = 'none';
            const wrapper = document.createElement('div');
            wrapper.className = 'custom-select-wrapper';
            select.parentNode.insertBefore(wrapper, select);
            wrapper.appendChild(select);
            
            const trigger = document.createElement('div');
            trigger.className = 'custom-select-trigger';
            trigger.innerHTML = '<span>' + (select.options[select.selectedIndex]?.text || '') + '</span><i class="fa-solid fa-chevron-down" style="font-size: 0.8rem; color: #888;"></i>';
            wrapper.appendChild(trigger);
            
            const optionsContainer = document.createElement('div');
            optionsContainer.className = 'custom-options';
            wrapper.appendChild(optionsContainer);
            
            Array.from(select.options).forEach(function(option, index) {
                const customOption = document.createElement('div');
                customOption.className = 'custom-option' + (option.selected ? ' selected' : '');
                customOption.textContent = option.text;
                customOption.dataset.value = option.value;
                
                customOption.addEventListener('click', function() {
                    select.selectedIndex = index;
                    trigger.querySelector('span').textContent = option.text;
                    optionsContainer.querySelectorAll('.custom-option').forEach(opt => opt.classList.remove('selected'));
                    this.classList.add('selected');
                    wrapper.classList.remove('open');
                    trigger.querySelector('i').className = 'fa-solid fa-chevron-down';
                    select.dispatchEvent(new Event('change'));
                });
                
                optionsContainer.appendChild(customOption);
            });
            
            trigger.addEventListener('click', function(e) {
                e.stopPropagation();
                const isOpen = wrapper.classList.contains('open');
                document.querySelectorAll('.custom-select-wrapper').forEach(w => {
                    w.classList.remove('open');
                    w.querySelector('.custom-select-trigger i').className = 'fa-solid fa-chevron-down';
                });
                if (!isOpen) {
                    wrapper.classList.add('open');
                    trigger.querySelector('i').className = 'fa-solid fa-chevron-up';
                }
            });
        });

        document.addEventListener('click', function() {
            document.querySelectorAll('.custom-select-wrapper').forEach(wrapper => {
                wrapper.classList.remove('open');
                wrapper.querySelector('.custom-select-trigger i').className = 'fa-solid fa-chevron-down';
            });
        });
    });
</script>
</body>
</html>
