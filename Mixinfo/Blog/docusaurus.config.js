// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const lightCodeTheme = require('prism-react-renderer/themes/github');
const darkCodeTheme = require('prism-react-renderer/themes/dracula');

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: '知行合一',
  tagline: '知识体系建设',
  favicon: 'img/favicon.ico',

  // Set the production url of your site here
  url: 'https://iewiewiew.github.io',
  baseUrl: '/',

  organizationName: 'iewiewiew',
  projectName: 'iewiewiew.github.io',
  deploymentBranch: 'gh-pages',

  onBrokenLinks: 'ignore',
  onBrokenMarkdownLinks: 'warn',

  i18n: {
    defaultLocale: 'zh-Hans',
    locales: ['zh-Hans'],
  },

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: require.resolve('./sidebars.js'),
          exclude: ['Chaos/高可用测试用例模板.md', 'Database/MongoDB/**', 'Mixinfo/MarkdownSet/markdown-example.md', 'Mixinfo/MarkdownSet/mix/*'],
        },
        blog: {
          showReadingTime: true,
        },
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      }),
    ],
  ],

  themeConfig: {
      // 添加 Algolia DocSearch 配置
      algolia: {
        appId: 'ZNU4NQPM1V',
        apiKey: '9e0a0edea7d0ed5a8ba205d859ab54a1',
        indexName: 'wei-notebook',
        contextualSearch: true, // 可选：启用上下文搜索
        // 可选：Algolia 搜索参数
        searchParameters: {},
        // 可选：搜索页面的路径，默认是 false (禁用)
        searchPagePath: 'search',
      },
    image: 'img/me.jpeg',
    navbar: {
      title: 'wei',
      logo: {
        alt: 'My Site Logo',
        src: 'img/me.jpeg',
      },
      items: [
        {
          type: 'docSidebar',
          sidebarId: 'tutorialSidebar',
          position: 'left',
          label: '目录',
        },
        {
          href: "https://www.processon.com/mindmap/6138112f1e085306ef9fe608",
          label: "技能图谱",
          position: "left",
        },
        {
          href: 'https://github.com/iewiewiew',
          label: 'GitHub',
          position: 'right',
        },
      ],
    },
    footer: {
      style: 'dark',
      copyright: `Copyright © ${new Date().getFullYear()} My Project, Inc. Built with Docusaurus.`,
    },
    prism: {
      theme: lightCodeTheme,
      darkTheme: darkCodeTheme,
    },
  },

  // 启动后重定向到 /docs 页面（注：未生效）
  plugins: [
      function myPlugin() {
        return {
          name: 'docusaurus-plugin-redirect',
          onRouteChange({ location }) {
            if (location.pathname === '/') {
              window.location.replace('/docs/');
            }
          },
        };
      },
    ],

};

module.exports = config;