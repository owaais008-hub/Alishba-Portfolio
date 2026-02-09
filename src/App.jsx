import React, { useState } from "react";
import "./Portfolio.css";

// Import images
import project1 from "./assets/project1.png";
import project2 from "./assets/project2.png";
import project3 from "./assets/project3.png";
import project4 from "./assets/project4.png";

function App() {
  const [filter, setFilter] = useState("All");
  const [activeHash, setActiveHash] = useState("#home");

  React.useEffect(() => {
    const handleScroll = () => {
      const sections = ["home", "about", "experience", "portfolio", "contact"];
      const scrollPosition = window.scrollY + 100; // Offset for header

      for (const section of sections) {
        const element = document.getElementById(section);
        if (element) {
          const offsetTop = element.offsetTop;
          const offsetHeight = element.offsetHeight;

          if (
            scrollPosition >= offsetTop &&
            scrollPosition < offsetTop + offsetHeight
          ) {
            setActiveHash(`#${section}`);
            break;
          }
        }
      }
    };

    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  const projects = [
    {
      id: 1,
      title: "MedTrack Pro (Flutter)",
      desc: "A mission-critical medicine reminder app featuring local notifications and a minimalist user interface.",
      category: "Web Apps", // Using Web Apps for now as filter matches
      image: project1
    },
    {
      id: 2,
      title: "NexTrade Dashboard",
      desc: "High-performance financial analytics portal designed for real-time market tracking and data visualization.",
      category: "Web Apps",
      image: project2,
    },
    {
      id: 3,
      title: "Aptech Connect",
      desc: "A centralized campus event management system streamlining student participation and brand engagement.",
      category: "Design",
      image: project3
    },
    {
      id: 4,
      title: "Strategic Brand Audit",
      desc: "Comprehensive marketing analysis and digital transformation roadmap for local academic institutions.",
      category: "Consulting",
      image: project4,
    },
  ];

  const filteredProjects =
    filter === "All" ? projects : projects.filter((p) => p.category === filter);

  return (
    <div className="portfolio-app">
      {/* Desktop Navigation */}
      <nav className="desktop-nav">
        <div className="container nav-container">
          <div className="logo">ALISHBA ALEEM<span>.</span></div>
          <div className="nav-links">
            <a href="#home" className={activeHash === "#home" ? "active" : ""}>Home</a>
            <a href="#about" className={activeHash === "#about" ? "active" : ""}>About</a>
            <a href="#experience" className={activeHash === "#experience" ? "active" : ""}>Professional Journey</a>
            <a href="#portfolio" className={activeHash === "#portfolio" ? "active" : ""}>Portfolio</a>
            <a href="#contact" className={activeHash === "#contact" ? "active" : ""}>Contact</a>
          </div>
          <a href="#contact" className="btn btn-nav">Hire Me</a>
        </div>
      </nav>

      {/* Mobile Navigation */}
      <nav className="mobile-nav">
        <a href="#home" className={`nav-item ${activeHash === "#home" ? "active" : ""}`}>
          <i className="fas fa-home"></i>
          <span>Home</span>
        </a>
        <a href="#about" className={`nav-item ${activeHash === "#about" ? "active" : ""}`}>
          <i className="fas fa-user-circle"></i>
          <span>About</span>
        </a>
        <a href="#experience" className={`nav-item ${activeHash === "#experience" ? "active" : ""}`}>
          <i className="fas fa-history"></i>
          <span>Path</span>
        </a>
        <a href="#portfolio" className={`nav-item ${activeHash === "#portfolio" ? "active" : ""}`}>
          <i className="fas fa-th-large"></i>
          <span>Work</span>
        </a>
        <a href="#contact" className={`nav-item ${activeHash === "#contact" ? "active" : ""}`}>
          <i className="fas fa-paper-plane"></i>
          <span>Contact</span>
        </a>
      </nav>

      {/* Hero Section */}
      <header className="hero" id="home">
        <div className="hero-background">
          <div className="blob blob-1"></div>
          <div className="blob blob-2"></div>
        </div>
        <div className="hero-content">
          <div className="hero-status">
            <span className="pulse"></span> Open for Collaborations
          </div>
          <h1>
            Crafting Digital <span>Experiences</span>
          </h1>
          <p>Alishba Aleem — Software Engineering Student & Strategic Tech-Marketer</p>
          <div className="tagline">
            Merging analytical engineering with human-centric marketing.
          </div>
          <div className="hero-buttons">
            <a href="#portfolio" className="btn btn-primary">
              View Case Studies <i className="fas fa-chevron-right"></i>
            </a>
            <a href="#contact" className="btn btn-secondary">
              Get in Touch
            </a>
          </div>
        </div>
        <div className="scroll-indicator">
          <span></span>
        </div>
      </header>

      {/* About Section */}
      <section className="about" id="about">
        <div className="container">
          <div className="about-content">
            <h2 className="section-title">Professional Overview</h2>
            <h3>
              Where <span>Intelligence</span> Meets <span>Strategy</span>.
            </h3>
            <div className="about-text-wrapper">
              <p>
                I am Alishba Aleem, a Software Engineering student dedicated to building
                impactful digital solutions. My unique background as a lead <strong>Brand Ambassador</strong> at Aptech has equipped me with a rare dual perspective: the ability to write robust code
                and the insight to understand exactly what the end-user needs.
              </p>
              <p>
                Currently, I am architecting cross-platform mobile apps using the <strong>Flutter ecosystem</strong> and designing modern, responsive web architectures that prioritize performance and user experience.
              </p>
            </div>

            <div className="skills-tags">
              <span>Flutter & Dart Expert (Mastering)</span>
              <span>React & Modern Web</span>
              <span>UI Design Systems</span>
              <span>Strategic Brand Growth</span>
              <span>Full-Stack Mentality</span>
            </div>

            <div className="about-highlights">
              <div className="highlight-item">
                <i className="fas fa-shield-alt"></i>
                <span>Architecture First Approach</span>
              </div>
              <div className="highlight-item">
                <i className="fas fa-chart-line"></i>
                <span>Conversion Focused Design</span>
              </div>
              <div className="highlight-item">
                <i className="fas fa-users"></i>
                <span>Empathetic User Logic</span>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Experience Section */}
      <section className="experience" id="experience">
        <div className="container">
          <h2 className="section-title">Milestones</h2>
          <div className="experience-timeline">
            <div className="timeline-item">
              <div className="timeline-dot"></div>
              <div className="timeline-content">
                <div className="exp-header">
                  <div>
                    <h3>Lead Brand Ambassador</h3>
                    <h4>Aptech Metro Star Gate</h4>
                  </div>
                  <span className="exp-date">Jan 2026 - Present</span>
                </div>
                <ul className="exp-bullets">
                  <li>Designing and executing marketing strategies to enhance student enrollment and engagement.</li>
                  <li>Facilitating academic seminars and representing the institute at key community events.</li>
                  <li>Bridging the gap between technical curriculum and student career aspirations.</li>
                </ul>
                <div className="exp-tags">
                  <span>Leadership</span>
                  <span>Strategic Marketing</span>
                  <span>Event Coordination</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Portfolio Section */}
      <section className="portfolio" id="portfolio">
        <div className="container">
          <h2 className="section-title">Showcase</h2>
          <div className="filters">
            {["All", "Web Apps", "Design", "Consulting"].map((cat) => (
              <button
                key={cat}
                className={`filter-btn ${filter === cat ? "active" : ""}`}
                onClick={() => setFilter(cat)}
              >
                {cat}
              </button>
            ))}
          </div>
          <div className="projects-grid">
            {filteredProjects.map((project) => (
              <div key={project.id} className="project-card">
                <div className="project-img-wrapper">
                  <img
                    src={project.image}
                    alt={project.title}
                  />
                  <div className="project-overlay">
                    <span className="view-project">Interaction Design</span>
                  </div>
                </div>
                <div className="project-info">
                  <span className="project-cat">{project.category}</span>
                  <h3>{project.title}</h3>
                  <p>{project.desc}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Contact Section */}
      <section className="contact" id="contact">
        <div className="container">
          <div className="contact-grid">
            <div className="contact-details">
              <h2 className="section-title left">Let's Build the Future</h2>
              <p>
                Available for freelance opportunities, open-source collaborations,
                and full-time engineering roles. Let's transform your vision into
                a high-performance digital reality.
              </p>

              <div className="info-list">
                <div className="info-item">
                  <i className="fas fa-paper-plane"></i>
                  <div>
                    <label>Inquiries</label>
                    <span>alyshbaaleem@gmail.com</span>
                  </div>
                </div>
                <div className="info-item">
                  <i className="fas fa-compass"></i>
                  <div>
                    <label>Currently Based</label>
                    <span>Shah Faisal, Karachi, Pakistan</span>
                  </div>
                </div>
              </div>

              <div className="social-links">
                <a href="https://linkedin.com/in/alishba-aleem-flutter-developer-details-skills" title="LinkedIn" target="_blank" rel="noopener noreferrer">
                  <i className="fab fa-linkedin-in"></i>
                </a>
                <a href="https://github.com/Alyshbaaleem" title="GitHub" target="_blank" rel="noopener noreferrer">
                  <i className="fab fa-github"></i>
                </a>
                <a href="#" title="Behance">
                  <i className="fab fa-behance"></i>
                </a>
              </div>
            </div>

            <form className="contact-form" onSubmit={(e) => e.preventDefault()}>
              <div className="form-group">
                <input type="text" placeholder="Full Name" required />
              </div>
              <div className="form-group">
                <input type="email" placeholder="Email Address" required />
              </div>
              <div className="form-group">
                <textarea placeholder="Describe your project or inquiry..." rows="5" required></textarea>
              </div>
              <button type="submit" className="btn btn-primary">
                Send Message <i className="fas fa-rocket"></i>
              </button>
            </form>
          </div>
        </div>
      </section>

      <footer>
        <div className="container">
          <div className="footer-content">
            <div className="footer-logo">ALISHBA ALEEM<span>.</span></div>
            <p>&copy; 2026. All rights reserved. Designed for Impact.</p>
          </div>
        </div>
      </footer>
    </div>
  );
}

export default App;
