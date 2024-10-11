// ==UserScript==
// @name         Github status check sort
// @namespace    https://github.com/
// @version      1.1.3
// @description  Sort the status checks on a PR by status and then by name
// @author       Skjnldsv
// @match        https://github.com/*/*/pull/*
// @icon         https://github.githubassets.com/favicons/favicon.svg
// @grant        none
// @updateURL    https://gist.github.com/skjnldsv/eb7b894ae996affde4a7d0e00e0d80a1/raw/github-status-check-sort.user.js
// @downloadURL  https://gist.github.com/skjnldsv/eb7b894ae996affde4a7d0e00e0d80a1/raw/github-status-check-sort.user.js
// ==/UserScript==

(function() {
    'use strict';
    const targetNode = document.querySelector('.discussion-timeline-actions')
    const config = { attributes: false, childList: true, subtree: false }

    const callback = (mutationList) => {
        if ([...mutationList[0].removedNodes].length > 0) {
            const container = document.querySelector('.merge-status-list > div.merge-status-item').parentElement
            const children = Array.prototype.slice.call(container.querySelectorAll('div.merge-status-item'), 0)
            while (container.firstChild) {
                container.removeChild(container.firstChild);
            }
            container.append(...children.sort((a, b) => {
                const iconSelector = '.merge-status-icon svg'
                const statusCheckError = a.querySelector(iconSelector).classList.contains('octicon-x') - b.querySelector(iconSelector).classList.contains('octicon-x')
                const statusCheckStop = a.querySelector(iconSelector).classList.contains('octicon-stop') - b.querySelector(iconSelector).classList.contains('octicon-stop')
                const statusCheckInProgress = a.querySelector(iconSelector).classList.contains('anim-rotate') - b.querySelector(iconSelector).classList.contains('anim-rotate')
                const statusCheckQueued = a.querySelector(iconSelector).classList.contains('octicon-dot-fill') - b.querySelector(iconSelector).classList.contains('octicon-dot-fill')
                const statusCheckSkip = a.querySelector(iconSelector).classList.contains('octicon-skip') - b.querySelector(iconSelector).classList.contains('octicon-skip')
                const statusCheckSuccess = a.querySelector(iconSelector).classList.contains('octicon-check') - b.querySelector(iconSelector).classList.contains('octicon-check')
                const statusCheckNeutral = a.querySelector(iconSelector).classList.contains('octicon-square-fill') - b.querySelector(iconSelector).classList.contains('octicon-square-fill')

                const aText = a.innerText.toLowerCase();
                const bText = b.innerText.toLowerCase();

                // Prioritize checks with "k8s diff" to the bottom
                const containsK8sDiff = aText.includes("k8s diff") - bText.includes("k8s diff");
                if (containsK8sDiff !== 0) {
                    return containsK8sDiff;
                }

                // Sort order: error -> in progress -> stop -> queued -> neutral -> skip -> success -> name
                return statusCheckSuccess || statusCheckSkip || statusCheckNeutral || statusCheckQueued || statusCheckStop || statusCheckInProgress || statusCheckError
                    || aText.localeCompare(bText)
            }))
        }
    }

    const observer = new MutationObserver(callback)
    observer.observe(targetNode, config)

})();

