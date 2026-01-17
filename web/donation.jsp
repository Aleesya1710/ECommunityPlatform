<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Support Our Cause - E-Community Platform</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet">
    <style>
        .btn-primary {
            background-color: #F7DE4F;
            color: #333333;
            transition: all 0.2s ease;
        }
        .btn-primary:hover {
            background-color: #F4D10B;
            transform: scale(1.05);
        }
        .donation-card {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        .donation-card:hover {
            transform: translateY(-5px);
        }
    </style>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'primary-accent': '#F7DE4F',
                        'secondary-accent': '#F4D10B',
                        'web-bg': '#FCF2BB',
                        'text-dark': '#333333',
                    },
                    fontFamily: {
                        sans: ['Inter', 'sans-serif'],
                    },
                }
            }
        }
    </script>
</head>
<body class="bg-web-bg font-sans text-text-dark min-h-screen flex flex-col">
    <%@ include file="header.jsp" %>
    <main class="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
        <div class="text-center mb-12">
            <h1 class="text-4xl sm:text-5xl font-extrabold mb-4">Support Our Cause</h1>
            <p class="text-lg text-gray-600 max-w-3xl mx-auto">
                Your contribution helps us keep the platform running, supporting hundreds of community organizations and thousands of volunteers every day.
            </p>
        </div>
        <div class="bg-white p-8 sm:p-12 rounded-2xl shadow-2xl mb-8">
            <div class="mb-8">
                <h2 class="text-2xl font-bold mb-6 text-center">Choose Your Donation Amount</h2>
                <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
                    <button class="donation-card p-6 text-center border-2 border-gray-200 hover:border-primary-accent">
                        <p class="text-3xl font-bold text-primary-accent">RM50</p>
                        <p class="text-sm text-gray-500 mt-2">Basic Support</p>
                    </button>
                    <button class="donation-card p-6 text-center border-2 border-gray-200 hover:border-primary-accent">
                        <p class="text-3xl font-bold text-primary-accent">RM100</p>
                        <p class="text-sm text-gray-500 mt-2">Help More</p>
                    </button>
                    <button class="donation-card p-6 text-center border-2 border-gray-200 hover:border-primary-accent">
                        <p class="text-3xl font-bold text-primary-accent">RM250</p>
                        <p class="text-sm text-gray-500 mt-2">Make Impact</p>
                    </button>
                    <button class="donation-card p-6 text-center border-2 border-gray-200 hover:border-primary-accent">
                        <p class="text-3xl font-bold text-primary-accent">RM500</p>
                        <p class="text-sm text-gray-500 mt-2">Champion</p>
                    </button>
                </div>
                <div class="text-center">
                    <label class="block text-gray-700 font-semibold mb-3">Or Enter Custom Amount</label>
                    <div class="max-w-xs mx-auto flex items-center">
                        <span class="text-2xl font-bold mr-2">RM</span>
                        <input type="number" 
                               placeholder="Enter amount" 
                               class="flex-1 px-4 py-3 text-lg border-2 border-gray-300 rounded-lg focus:outline-none focus:border-primary-accent"
                               min="1">
                    </div>
                </div>
            </div>
            <div class="border-t-2 border-gray-100 pt-8">
                <h2 class="text-2xl font-bold mb-6 text-center">Payment Methods</h2>
                
                <div class="grid md:grid-cols-2 gap-8">
                    <div class="donation-card p-6 border-2 border-gray-200">
                        <h3 class="text-xl font-bold mb-4 flex items-center">
                            <span class="text-2xl mr-2">🏦</span>
                            Bank Transfer
                        </h3>
                        <div class="space-y-3 text-gray-700">
                            <div>
                                <p class="text-sm text-gray-500">Bank Name</p>
                                <p class="font-semibold">Maybank (Malayan Banking Berhad)</p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Account Name</p>
                                <p class="font-semibold">E-Community Platform Malaysia</p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Account Number</p>
                                <p class="font-mono font-bold text-lg">5642 1234 5678</p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">SWIFT Code</p>
                                <p class="font-mono font-semibold">MBBEMYKL</p>
                            </div>
                            <div class="pt-2 border-t border-gray-200">
                                <p class="text-xs text-gray-500">Also accepts: CIMB, Public Bank, RHB, Hong Leong Bank</p>
                            </div>
                        </div>
                    </div>
                    <div class="donation-card p-6 border-2 border-gray-200 text-center">
                        <h3 class="text-xl font-bold mb-4 flex items-center justify-center">
                            <span class="text-2xl mr-2">📱</span>
                            Scan to Donate
                        </h3>
                        <div class="bg-gray-100 p-6 rounded-lg inline-block">
                            <svg width="200" height="200" viewBox="0 0 200 200" class="mx-auto">
                                <rect width="200" height="200" fill="white"/>
                                <g fill="#333333">
                                    <rect x="10" y="10" width="60" height="60"/>
                                    <rect x="20" y="20" width="40" height="40" fill="white"/>
                                    <rect x="30" y="30" width="20" height="20"/>                  
                                    <rect x="130" y="10" width="60" height="60"/>
                                    <rect x="140" y="20" width="40" height="40" fill="white"/>
                                    <rect x="150" y="30" width="20" height="20"/>
                                    <rect x="10" y="130" width="60" height="60"/>
                                    <rect x="20" y="140" width="40" height="40" fill="white"/>
                                    <rect x="30" y="150" width="20" height="20"/>
                                    <rect x="80" y="20" width="10" height="10"/>
                                    <rect x="100" y="20" width="10" height="10"/>
                                    <rect x="90" y="40" width="10" height="10"/>
                                    <rect x="110" y="50" width="10" height="10"/>
                                    <rect x="80" y="80" width="10" height="10"/>
                                    <rect x="100" y="90" width="10" height="10"/>
                                    <rect x="120" y="100" width="10" height="10"/>
                                    <rect x="90" y="110" width="10" height="10"/>
                                    <rect x="110" y="120" width="10" height="10"/>
                                    <rect x="140" y="130" width="10" height="10"/>
                                    <rect x="160" y="140" width="10" height="10"/>
                                    <rect x="150" y="160" width="10" height="10"/>
                                    <rect x="80" y="150" width="10" height="10"/>
                                    <rect x="100" y="160" width="10" height="10"/>
                                    <rect x="90" y="170" width="10" height="10"/>
                                </g>
                            </svg>
                        </div>
                        <p class="text-sm text-gray-600 mt-4">
                            Scan with your banking app or e-wallet
                        </p>
                        <p class="text-xs text-gray-500 mt-2">
                            Supports: Touch 'n Go eWallet, GrabPay, Boost, ShopeePay, BigPay
                        </p>
                    </div>

                </div>

                <div class="mt-8 text-center">
                    <button class="btn-primary px-10 py-4 text-lg font-bold rounded-full shadow-lg hover:shadow-xl uppercase inline-flex items-center">
                        <span class="text-2xl mr-3">💳</span>
                        Donate with Credit/Debit Card
                    </button>
                </div>
            </div>
            <div class="mt-8 text-center">
                <p class="text-sm text-gray-500">
                    ✓ All donations are secure and may be tax-deductible
                </p>
                <p class="text-xs text-gray-400 mt-2">
                    ROC No: 202301234567 | Registered Non-Profit Organization under ROS Malaysia
                </p>
            </div>
        </div>
        <div class="grid md:grid-cols-3 gap-6 mb-8">
            <div class="bg-white p-6 rounded-xl shadow-lg text-center">
                <div class="text-4xl mb-3">🎯</div>
                <h3 class="text-2xl font-bold text-primary-accent mb-2">1,500+</h3>
                <p class="text-gray-600">Active Volunteers</p>
            </div>
            <div class="bg-white p-6 rounded-xl shadow-lg text-center">
                <div class="text-4xl mb-3">🏘️</div>
                <h3 class="text-2xl font-bold text-primary-accent mb-2">300+</h3>
                <p class="text-gray-600">Community Projects</p>
            </div>
            <div class="bg-white p-6 rounded-xl shadow-lg text-center">
                <div class="text-4xl mb-3">❤️</div>
                <h3 class="text-2xl font-bold text-primary-accent mb-2">50,000+</h3>
                <p class="text-gray-600">Lives Impacted</p>
            </div>
        </div>
        <div class="bg-white p-8 rounded-xl shadow-lg text-center">
            <p class="text-lg text-gray-700 italic mb-4">
                "Thanks to the generous donations from supporters like you, we've been able to connect thousands of volunteers with meaningful opportunities to make a real difference in their communities."
            </p>
            <p class="font-semibold text-text-dark">- E-Community Platform Team</p>
        </div>

    </main>
    <footer class="bg-text-dark text-white py-6 mt-16">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center text-sm">
            &copy; 2025 E-Community Service Platform. All rights reserved.
        </div>
    </footer>

    <script>
        const donationButtons = document.querySelectorAll('.donation-card button, .grid button');
        const customAmountInput = document.querySelector('input[type="number"]');
        
        donationButtons.forEach(button => {
            button.addEventListener('click', function() {
                donationButtons.forEach(btn => {
                    btn.classList.remove('border-primary-accent', 'bg-yellow-50');
                });
                this.classList.add('border-primary-accent', 'bg-yellow-50');
                const amountText = this.querySelector('p')?.textContent;
                if (amountText && amountText.includes('RM')) {
                    customAmountInput.value = amountText.replace('RM', '');
                }
            });
        });
        customAmountInput.addEventListener('input', function() {
            donationButtons.forEach(btn => {
                btn.classList.remove('border-primary-accent', 'bg-yellow-50');
            });
        });
        document.querySelector('.btn-primary').addEventListener('click', function() {
            const amount = customAmountInput.value || '100';
            alert(`Processing donation of RM${amount}. This would redirect to a secure payment gateway in production.`);
        });
    </script>
</body>
</html>