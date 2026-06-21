function normalizeLocationValue(value) {
    return String(value || '')
        .normalize('NFD')
        .replace(/[\u0300-\u036f]/g, '')
        .trim()
        .toLocaleUpperCase('es-PE');
}

function findMatchingLocationValue(values, selectedValue) {
    const selected = normalizeLocationValue(selectedValue);
    if (!selected) {
        return '';
    }

    return values.find((value) => normalizeLocationValue(value) === selected) || selectedValue;
}

function fillLocationSelect(select, values, selectedValue) {
    select.innerHTML = '<option value="">Seleccione</option>';
    const selected = findMatchingLocationValue(values, selectedValue);

    values.forEach((value) => {
        const option = document.createElement('option');
        option.value = value;
        option.textContent = value;
        option.selected = value === selected;
        select.appendChild(option);
    });
}

function initPeruAddressSelects() {
    document.querySelectorAll('[data-peru-address]').forEach((root) => {
        const department = root.querySelector('[data-address-department]');
        const province = root.querySelector('[data-address-province]');
        const district = root.querySelector('[data-address-district]');

        if (!department || !province || !district) {
            return;
        }

        let locations = {};
        try {
            locations = JSON.parse(root.dataset.locations || '{}');
        } catch {
            locations = {};
        }

        department.value = findMatchingLocationValue(
            Object.keys(locations),
            department.dataset.selected || department.value,
        );

        const populateDistricts = () => {
            const provinceMap = locations[department.value] || {};
            fillLocationSelect(district, provinceMap[province.value] || [], district.dataset.selected || '');
        };

        const populateProvinces = () => {
            const provinceMap = locations[department.value] || {};
            fillLocationSelect(province, Object.keys(provinceMap), province.dataset.selected || '');
            province.value = findMatchingLocationValue(Object.keys(provinceMap), province.dataset.selected || province.value);
            populateDistricts();
        };

        department.addEventListener('change', () => {
            province.dataset.selected = '';
            district.dataset.selected = '';
            populateProvinces();
        });

        province.addEventListener('change', () => {
            district.dataset.selected = '';
            populateDistricts();
        });

        populateProvinces();
    });
}

function initPaymentVerification() {
    const button = document.querySelector('[data-verify-payments]');
    const form = button?.closest('form');
    const result = document.querySelector('[data-payment-verification-result]');

    if (!button || !form || !result) {
        return;
    }

    button.addEventListener('click', async () => {
        result.textContent = 'Verificando pagos...';
        result.className = 'mt-3 rounded-lg border border-blue-200 bg-blue-50 px-4 py-3 text-sm font-semibold text-blue-800';

        try {
            const response = await fetch(button.dataset.verifyPaymentsUrl, {
                method: 'POST',
                headers: {
                    Accept: 'application/json',
                    'X-Requested-With': 'XMLHttpRequest',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')?.content || '',
                },
                body: new FormData(form),
            });
            const payload = await response.json();
            result.className = payload.ok
                ? 'mt-3 rounded-lg border border-emerald-200 bg-emerald-50 px-4 py-3 text-sm font-semibold text-emerald-800'
                : 'mt-3 rounded-lg border border-amber-200 bg-amber-50 px-4 py-3 text-sm font-semibold text-amber-800';
            result.innerHTML = payload.message || 'Verificacion finalizada.';

            if (Array.isArray(payload.items) && payload.items.length > 0) {
                result.innerHTML += '<ul class="mt-2 list-disc pl-5">' + payload.items.map((item) => `<li>${item}</li>`).join('') + '</ul>';
            }
        } catch {
            result.className = 'mt-3 rounded-lg border border-red-200 bg-red-50 px-4 py-3 text-sm font-semibold text-red-800';
            result.textContent = 'No se pudo verificar los pagos.';
        }
    });
}

document.addEventListener('DOMContentLoaded', initPeruAddressSelects);
document.addEventListener('DOMContentLoaded', initPaymentVerification);
