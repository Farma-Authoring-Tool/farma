import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  connect() {
    if (window.tinymce && tinymce.get(this.element.id)) {
      tinymce.get(this.element.id).remove()
    }

    if (this.element.id === "no-tinymce") return

    tinymce.init({
      target: this.element,
      license_key: "gpl",
      height: 300,
      menubar: false,

      content_style: "body { color: #4B5563; }",

      toolbar: [
        "undo redo | styles | bold italic underline superscript subscript | forecolor backcolor | alignleft aligncenter alignright alignjustify",
        "bullist numlist outdent indent | link image table | charmap emoticons | removeformat | help"
      ],

      plugins: [
        "insertdatetime", "lists", "link", "image", "table", "code", "help", "wordcount", "charmap", "emoticons",
        "advlist", "autolink", "autosave", "directionality", "fullscreen", "nonbreaking", "preview", "searchreplace", "visualblocks", "visualchars"
      ],

      images_upload_url: "/educators/uploader/image",
    })
  }

  disconnect() {
    if (window.tinymce && tinymce.get(this.element.id)) {
      tinymce.get(this.element.id).remove()
    }
  }
}
