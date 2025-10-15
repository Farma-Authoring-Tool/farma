import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    if (window.tinymce && tinymce.get(this.element.id)) {
      tinymce.get(this.element.id).remove()
    }

    tinymce.init({
      target: this.element,
      license_key: "gpl",
      height: 300,
      menubar: false,
      content_style: "body { color: #4B5563; }",
      toolbar: [
        "undo redo | styles | bold italic underline superscript subscript | forecolor backcolor | alignleft aligncenter alignright alignjustify",
        "bullist numlist outdent indent | link image media table | charmap emoticons | code | removeformat | help"
      ],
      plugins: [
        "insertdatetime", "lists", "link", "image", "media", "table", "code", "help", "wordcount", "charmap", "emoticons",
        "advlist", "autolink", "autosave", "directionality", "fullscreen", "nonbreaking", "preview", "searchreplace", "visualblocks", "visualchars"
      ],

      style_formats: [
        { title: 'Título', block: 'h2' },
        { title: 'Subtítulo', block: 'h3' },
        { title: 'Parágrafo', block: 'p' },
        { title: 'Código', block: 'pre', classes: 'language-js' }
      ]
    })

    this.element.form.addEventListener("submit", () => {
      if (window.tinymce) {
        const editor = tinymce.get(this.element.id)
        if (editor) editor.save() 
      }
    })
  }

  disconnect() {
    if (window.tinymce && tinymce.get(this.element.id)) {
      tinymce.get(this.element.id).remove()
    }
  }
}
