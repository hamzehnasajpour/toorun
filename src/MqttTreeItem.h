#ifndef MQTTTREEITEM_H
#define MQTTTREEITEM_H

#include <QList>
#include <QVariant>

class MqttTreeItem
{
public:
    explicit MqttTreeItem(const QList<QVariant> &data, MqttTreeItem *parentItem = 0);
    ~MqttTreeItem();

    void appendChild(MqttTreeItem *child);
    void insert(int i, MqttTreeItem *item);

    MqttTreeItem *child(int row);
    int childCount() const;
    int columnCount() const;
    QVariant data(int column) const;
    int row() const;
    MqttTreeItem *parentItem();
    void removeAll();
    
private:
    QList<MqttTreeItem*> m_childItems;
    QList<QVariant> m_itemData;
    MqttTreeItem *m_parentItem;
};

#endif
