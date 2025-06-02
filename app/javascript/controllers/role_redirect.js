document.addEventListener('DOMContentLoaded', () => {
  const button = document.getElementById('continue-button');

  if (!button) return;

  button.addEventListener('click', () => {
    const selected = document.querySelector('input[name="role"]:checked');

    if (!selected) {
      alert('Por favor, selecione uma opção.');
      return;
    }

    const role = selected.value;
    const alunoUrl = button.dataset.alunoUrl;
    const professorUrl = button.dataset.professorUrl;

    if (role === 'aluno') {
      window.location.href = alunoUrl;
    } else if (role === 'professor') {
      window.location.href = professorUrl;
    }
  });
});
