import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 
    "setupSection", "quizSection", "resultSection", 
    "lessonSelect", "questionText", "optionsContainer", 
    "nextButton", "progressBar", "progressText",
    "finalScore", "finalTotal", "resultMessage"
  ]

  connect() {
    this.questions = []
    this.currentIndex = 0
    this.userAnswers = []
  }

  async start() {
    const lessonId = this.lessonSelectTarget.value
    const response = await fetch(`/test_attempts/start_test?lesson_id=${lessonId}`)
    this.questions = await response.json()
    
    if (this.questions.length > 0) {
      this.setupSectionTarget.classList.add("d-none")
      this.quizSectionTarget.classList.remove("d-none")
      this.renderQuestion()
    } else {
      alert("Bài học này chưa có từ vựng!")
    }
  }

  renderQuestion() {
    const q = this.questions[this.currentIndex]
    this.questionTextTarget.textContent = q.question
    this.optionsContainerTarget.innerHTML = ""
    this.nextButtonTarget.classList.add("d-none")

    q.options.forEach(opt => {
      const btn = document.createElement("button")
      btn.className = "btn btn-outline-secondary btn-lg w-100 py-3 mb-2"
      btn.textContent = opt
      btn.dataset.action = "click->quiz#selectOption"
      
      const wrapper = document.createElement("div")
      wrapper.className = "col-6"
      wrapper.appendChild(btn)
      this.optionsContainerTarget.appendChild(wrapper)
    })

    this.updateProgress()
  }

  selectOption(e) {
    // Reset styles
    this.optionsContainerTarget.querySelectorAll("button").forEach(b => {
      b.classList.remove("btn-primary", "text-white")
      b.classList.add("btn-outline-secondary")
    })

    // Highlight selected
    e.target.classList.remove("btn-outline-secondary")
    e.target.classList.add("btn-primary", "text-white")
    
    this.currentSelection = e.target.textContent
    this.nextButtonTarget.classList.remove("d-none")
    this.nextButtonTarget.textContent = (this.currentIndex === this.questions.length - 1) ? "Hoàn thành" : "Tiếp theo"
  }

  next() {
    // Lưu câu trả lời
    this.userAnswers.push({
      vocabulary_id: this.questions[this.currentIndex].vocabulary_id,
      selected_answer: this.currentSelection
    })

    if (this.currentIndex < this.questions.length - 1) {
      this.currentIndex++
      this.renderQuestion()
    } else {
      this.submitQuiz()
    }
  }

  async submitQuiz() {
    const lessonId = this.lessonSelectTarget.value
    const token = document.querySelector('meta[name="csrf-token"]').content

    const response = await fetch("/test_attempts/submit_test", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": token
      },
      body: JSON.stringify({
        lesson_id: lessonId,
        answers: this.userAnswers
      })
    })

    const result = await response.json()
    this.showResult(result)
  }

  showResult(result) {
    this.quizSectionTarget.classList.add("d-none")
    this.resultSectionTarget.classList.remove("d-none")
    this.finalScoreTarget.textContent = result.score
    this.finalTotalTarget.textContent = result.total
  }

  updateProgress() {
    const percent = ((this.currentIndex) / this.questions.length) * 100
    this.progressBarTarget.style.width = `${percent}%`
    this.progressTextTarget.textContent = `Câu hỏi ${this.currentIndex + 1}/${this.questions.length}`
  }
}