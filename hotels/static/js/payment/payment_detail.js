// Payment Detail Page JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // Handle Notes Section Expand/Collapse
    const notesHeader = document.getElementById('notesHeader');
    const notesContent = document.getElementById('notesContent');
    
    if (notesHeader && notesContent) {
        // Automatically expand notes if they're short
        const notesContainer = notesContent.querySelector('.notes-container');
        if (notesContainer && notesContainer.textContent.trim().length < 100) {
            toggleNotesSection();
        }
        
        notesHeader.addEventListener('click', toggleNotesSection);
    }
    
    function toggleNotesSection() {
        notesHeader.classList.toggle('active');
        notesContent.classList.toggle('expanded');
    }
    
    // Handle Image Modal
    const transferImageThumbnail = document.getElementById('transferImageThumbnail');
    const imageModal = document.getElementById('imageModal');
    const modalImage = document.getElementById('modalImage');
    const closeModal = document.querySelector('.close-modal');
    
    if (transferImageThumbnail && imageModal && modalImage) {
        transferImageThumbnail.addEventListener('click', function() {
            modalImage.src = this.src;
            imageModal.classList.add('show');
            document.body.style.overflow = 'hidden'; // Prevent scrolling
        });
        
        // Close modal when clicking the close button
        closeModal.addEventListener('click', closeImageModal);
        
        // Close modal when clicking outside the image
        imageModal.addEventListener('click', function(event) {
            if (event.target === imageModal) {
                closeImageModal();
            }
        });
        
        // Close modal with Escape key
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape' && imageModal.classList.contains('show')) {
                closeImageModal();
            }
        });
    }
    
    function closeImageModal() {
        imageModal.classList.remove('show');
        setTimeout(() => {
            modalImage.src = '';
            document.body.style.overflow = '';
        }, 300);
    }
    
    // Smooth animation for the back button
    const backButton = document.querySelector('.btn-back');
    if (backButton) {
        backButton.addEventListener('click', function(e) {
            const href = this.getAttribute('href');
            if (href) {
                e.preventDefault();
                document.body.style.opacity = 0;
                setTimeout(() => {
                    window.location.href = href;
                }, 300);
            }
        });
    }
    
    // Add fade-in animation to the page
    document.body.style.opacity = 0;
    setTimeout(() => {
        document.body.style.transition = 'opacity 0.5s ease';
        document.body.style.opacity = 1;
    }, 100);
    
    // Detect RTL languages and apply RTL direction if needed
    function detectRTL() {
        const userLanguage = navigator.language || navigator.userLanguage;
        const rtlLanguages = ['ar', 'he', 'fa', 'ur'];
        
        if (rtlLanguages.some(lang => userLanguage.startsWith(lang))) {
            document.documentElement.setAttribute('dir', 'rtl');
        }
    }
    
    // Uncomment to enable automatic RTL detection
    // detectRTL();
});