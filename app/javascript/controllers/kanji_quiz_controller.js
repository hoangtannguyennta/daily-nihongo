import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "questionArea", "questionText", "optionsContainer", "progressBar", "scoreBadge", "resultArea" ]

  connect() {
    this.score = 0
    this.totalAnswered = 0
    const paramsElement = document.getElementById("quiz-params")
    this.jlpt = paramsElement ? paramsElement.dataset.jlpt : ""
    this.loadNextQuestion()
  }

  async loadNextQuestion() {
    try {
      const response = await fetch(`/kanjis/quiz.json?jlpt_level=${this.jlpt}`)
      const data = await response.json()

      if (data.question === "Hết dữ liệu Kanji" || !data.question) {
        this.finishQuiz()
        return
      }

      this.renderQuestion(data)
    } catch (error) {
      console.error("Lỗi khi tải câu hỏi Kanji:", error)
    }
  }

  renderQuestion(data) {
    this.correctAnswer = data.correct
    this.questionTextTarget.textContent = data.question
    this.optionsContainerTarget.innerHTML = ""

    data.options.forEach(option => {
      const col = document.createElement("div")
      col.className = "col-md-6"
      
      const btn = document.createElement("button")
      btn.className = "btn btn-outline-light text-dark w-100 py-3 option-btn shadow-sm mb-2"
      btn.textContent = option
      btn.dataset.action = "click->kanji-quiz#checkAnswer"
      
      col.appendChild(btn)
      this.optionsContainerTarget.appendChild(col)
    })
  }

  checkAnswer(event) {
    const selectedOption = event.target.textContent
    const buttons = this.optionsContainerTarget.querySelectorAll('button')
    
    // Khóa các nút để tránh bấm nhiều lần
    buttons.forEach(btn => btn.disabled = true)

    if (selectedOption === this.correctAnswer) {
      event.target.classList.add("correct-flash")
      this.score++
    } else {
      event.target.classList.add("wrong-flash")
      // Hiển thị đáp án đúng để người học ghi nhớ
      buttons.forEach(btn => {
        if (btn.textContent === this.correctAnswer) {
          btn.classList.add("correct-flash")
        }
      })
    }

    this.totalAnswered++
    this.updateUI()
    setTimeout(() => this.loadNextQuestion(), 1000)
  }

  updateUI() {
    this.scoreBadgeTarget.textContent = `Điểm: ${this.score}`
    const progress = Math.min(this.totalAnswered * 10, 100) // Giả định tiến trình tăng 10% mỗi câu
    this.progressBarTarget.style.width = `${progress}%`
  }

  finishQuiz() {
    this.questionAreaTarget.classList.add("d-none")
    this.resultAreaTarget.classList.remove("d-none")
  }
}